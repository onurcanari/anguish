import {admin} from "../firebase";
import * as userService from "./userService";
import {Paged, Post, UpdatePostReactionsAction} from "../model";
import {firestore} from "firebase-admin";
import Timestamp = admin.firestore.Timestamp;
import FieldValue = firestore.FieldValue;

const POST_LIMIT = 20;
let db = admin.firestore()

async function createPost(userId: string, post: Post) {
  let documentReference = await getPostsCollection()
      .add({
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        content: post.content,
        tags: post.tags,
        user: userId,
        anonymous: post.anonymous,
        reactions: {}
      });
  post.id = documentReference.id;
  return post;
}

async function getPost(userId: string, postId: string) {
  const postDocument = await getPostsCollection().doc(postId).get()
  const reactionId = await userService.getUserReaction(userId, postId);
  return mapPost(postDocument, reactionId);
}

async function getPosts(userId: string, afterDate: Date | null, tag: number | null) {
  let postDocumentsQuery = getPostsCollection().orderBy("createdAt", "desc")

  if (tag) {
    postDocumentsQuery = postDocumentsQuery.where("tags", "array-contains", tag)
  }

  if (afterDate) {
    postDocumentsQuery = postDocumentsQuery.startAfter(Timestamp.fromDate(afterDate));
  }

  const postDocuments = await postDocumentsQuery.limit(POST_LIMIT).get()

  let reactionMap = await userService.getUserReactions(userId)
  let posts = postDocuments.docs.map(postDocument => mapPost(postDocument, reactionMap.get(postDocument.id)));

  return new Paged<Post>(posts.length, posts.length == POST_LIMIT, posts);
}

async function deletePost(id: string) {
  await getPostsCollection().doc(id).delete();
}

function getPostsCollection() {
  return db.collection("posts")
}

function mapPost(doc: FirebaseFirestore.DocumentSnapshot<FirebaseFirestore.DocumentData>, reactionId: number | undefined): Post {
  let content = doc.get("content")
  let tags = doc.get("tags")
  let anonymous = doc.get("anonymous")
  let createdAt = doc.get("createdAt") as Timestamp
  let reactionsField = doc.get("reactions")
  return new Post(doc.id, content, tags, createdAt.toDate(), anonymous, reactionId, reactionsField ? reactionsField : {})
}

function updatePostReaction(action: UpdatePostReactionsAction) {
  getPostsCollection().doc(action.postId).update({
    "reactions": {
      [action.reactionId]: FieldValue.increment(action.increase ? 1 : -1)
    }
  })
}

export {
  createPost,
  getPost,
  getPosts,
  deletePost,
  updatePostReaction
}