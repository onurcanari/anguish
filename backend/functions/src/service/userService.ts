import {admin} from "../firebase";
import {firestore} from "firebase-admin";
import {UpdatePostReactionsAction} from "../model";
import FieldValue = firestore.FieldValue;

let db = admin.firestore()

async function reactToPost(userId: string, postId: string, reactionId: number) {
  let userReactionsRef = getUserReactionsReference(userId);
  let userReactions = await userReactionsRef.get()
  let givenReactionId = userReactions.get(getReactionKey(postId)) as number | undefined;

  let reactions = {
    "reactions": {
      [postId]: givenReactionId && reactionId == givenReactionId ? FieldValue.delete() : reactionId
    }
  };
  await userReactionsRef.set(reactions, {merge: true})

  let updatePostActions: UpdatePostReactionsAction[] = []

  if (givenReactionId) {
    updatePostActions.push(new UpdatePostReactionsAction(postId, givenReactionId, false))
  }

  if (!givenReactionId || reactionId != givenReactionId) {
    updatePostActions.push(new UpdatePostReactionsAction(postId, reactionId, true))
  }
  return updatePostActions;
}

async function getUserReactions(userId: string) {
  let userReactionsRef = await getUserReactionsReference(userId).get();
  let reactions = userReactionsRef.get("reactions") as Map<string, number>;

  return new Map<string, number>(reactions ? Object.entries(reactions) : null);
}

async function getUserReaction(userId: string, postId: string) {
  let reactionMap = await getUserReactions(userId);
  return reactionMap.get(postId)
}

function getUserReactionsReference(userId: string) {
  return db.collection("user_reactions").doc(userId)
}

function getReactionKey(postId: string) {
  return `reactions.${postId}`;
}

export {
  reactToPost,
  getUserReaction,
  getUserReactions,
}