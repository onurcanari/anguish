import * as functions from "firebase-functions";
import * as postService from "./service/postService";
import * as userService from "./service/userService";
import {Post} from "./model";

const USER_ID = "udXtSoxvY5y4o8vucCdKCsj7acQg" as string;

exports.createPost = functions.https.onCall((data, context) => {
  const userId = getUserId(context);
  return postService.createPost(userId, data as Post);
});

exports.getPost = functions.https.onCall((data, context) => {
  const userId = getUserId(context);
  return postService.getPost(userId, data.postId);
});

exports.getPosts = functions.https.onCall(async (data, context) => {
  const userId = getUserId(context);
  let afterDate: Date | null = null;

  if (data?.afterDate) {
    afterDate = new Date(data.afterDate);
  }

  return postService.getPosts(userId, afterDate, data?.tag);
});

exports.deletePost = functions.https.onCall((data, context) => {
  return postService.deletePost(data.postId)
});

exports.reactToPost = functions.https.onCall(async (data, context) => {
  const userId = getUserId(context);
  const postId = data.postId as string;
  const reactionId = data.reactionId as number;

  let actions = await userService.reactToPost(userId, postId, reactionId);
  actions.forEach(postService.updatePostReaction);
});

function getUserId(context: any) {
  return context.auth?.uid || USER_ID;
}