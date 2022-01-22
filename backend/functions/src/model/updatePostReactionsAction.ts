export class UpdatePostReactionsAction {
  postId: string
  reactionId: number
  increase: boolean

  constructor(postId: string, reactionId: number, increase: boolean) {
    this.postId = postId;
    this.reactionId = reactionId;
    this.increase = increase;
  }
}