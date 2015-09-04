app.controller('UserTKWJobsNewController', function ($scope, $http, $routeParams) {
  function Editor(title, input, preview) {
    this.update = function () {
      var title_description = input.value.split('\n')[0]
      last = title_description.replace(/[^0-9a-z \-\_\.\,]/i, '')
      while(last != title_description){
        title_description = last
        last = title_description.replace(/[^0-9a-z \-\_\.\,]/i, '');
      };
      title.value = title_description;

      preview.innerHTML = markdown.toHTML(input.value);
    };
    input.editor = this;
    this.update();
  }

  new Editor($("title-output"), $("text-input"), $("markout"));

  $scope.status = 0;

  $scope.testee = function(){
    $scope.title += 1
  }

  $scope.create = function(){
    $http.post('/api/jobs', {job: {description: $("text-input").value, status: $scope.status}}).
    success(function(data, status, headers, config) {
      $scope.rezultat = data;
      window.location.replace("/user_tkw/jobs/"+data['body']['id']);
    }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  }

});
