export class Paged<T> {
  numberOfItems: number
  fetchNextPage: boolean
  items: T[]

  constructor(numberOfItems: number, fetchNextPage: boolean, items: T[]) {
    this.numberOfItems = numberOfItems;
    this.fetchNextPage = fetchNextPage;
    this.items = items;
  }
}