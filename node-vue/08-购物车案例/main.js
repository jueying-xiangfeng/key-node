const app = new Vue({
  el: '#app',
  data: {
    books: [
      {
        id: 1,
        name: '《算法导论》',
        date: '2006-8',
        price: 65.00,
        count: 1
      },
      {
        id: 2,
        name: '《网络安全》',
        date: '2020-10',
        price: 88.00,
        count: 1
      },
      {
        id: 3,
        name: '《编程XX》',
        date: '2016-9',
        price: 85.00,
        count: 1
      },
      {
        id: 4,
        name: '《代码大全》',
        date: '1996-8',
        price: 80.00,
        count: 1
      },
    ]
  },
  filters: {
    showPrice(price) {
      return '￥' + price.toFixed(2)
    }
  }
})