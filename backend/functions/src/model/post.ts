export class Post {
  id: string
  content: string
  tags: number[]
  createdAt: String
  anonymous: boolean
  givenReactionId: number | undefined
  reactions: [string, unknown][] | undefined

  constructor(id: string, content: string, tags: number[], createdAt: Date, anonymous: boolean,
              givenReactionId: number | undefined, reactions: [string, unknown][] | undefined) {
    this.id = id;
    this.content = content;
    this.tags = tags;
    this.createdAt = createdAt.toJSON();
    this.anonymous = anonymous;
    this.givenReactionId = givenReactionId;
    this.reactions = reactions;
  }
}
