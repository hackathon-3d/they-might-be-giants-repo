Parse.Cloud.afterSave("Rating", function (request) {
  console.error('request is:' + request);
  q = new Parse.Query("Rating");
  q.equalTo("checklist", request.object.checklist);
  q.find({
    success: function(results) {
      console.error('returned ' + results.length);
      var t = 0.0;
      for (var i = 0; i < results.length; i++) {
        console.error('result ' + i + ' ' + JSON.stringify(results[i]));
        t += parseFloat(results[i]['rating']);
      }
      
      console.error('avg is ' + (t/results.length));
    },
    error: function(error) {
      console.error("Error querying ratings " + error.code + ": " + error.message);
    }
  });
});