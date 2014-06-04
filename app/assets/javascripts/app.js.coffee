BookApp = angular.module("BookApp", [])

BookApp.controller("BooksCtrl", ["$scope", "$http", ($scope, $http) ->
	console.log "inside of the controller"
	$scope.books = []

	$scope.hello = "Hello World"

	$http.get("/books.json").success (data) ->
		$scope.books = data

	$scope.addBook = ->
		console.log $scope.newBook
		$http.post("/books.json", $scope.newBook).success (data) ->
			console.log "Book Saved"
			$scope.newBook = {}
			$scope.books.push(data)


	$scope.deleteBook = ->
		# index = @$index
		$http.delete("/books/#{@book.id}.json").success (data) =>
			console.log "book deleted"
			$scope.books.splice(@$index, 1)
])
#index = @$index equals to the fat arrow, =>
#$http.delete("/books/+@book.id+".json) = $http.delete("/books/#{@book.id}.json")
#for coffeescript, @book, or @ is the same thing as this in javascript, so: this.book = @book

BookApp.config(["$httpProvider", ($httpProvider) ->
	$httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')
])