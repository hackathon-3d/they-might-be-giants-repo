Parse.Cloud.afterSave("Rating", function (request) {
  console.error('request is:' + request);
  q = new Parse.Query("Rating");
  q.equalTo("checklist", request.object.checklist);
  q.find({
    success: function(results) {
      console.error('returned ' + results.length);
      var t = 0.0;
      var checkId = results[0].get("checklist").id;
        console.error("CHECKID: "+checkId);
      for (var i = 0; i < results.length; i++) {
        console.error('result ' + i + ' ' + results[i].get("rating"));
        t += results[i].get("rating");
      }
      
      var avg = t/results.length;

      z = new Parse.Query("CheckList");
      z.equalTo("objectId", checkId);
      z.find({
        success: function(result) {
        console.error(JSON.stringify(result));
           result[0].set("rating", avg);

           result[0].save(null, {
                success: function(result) {
                console.error("saved!");
                },
                error: function(result, error) {
                console.error(error);
                }
            });


           //result.push("rating", avg);
       },
       error: function(error) {
            console.error("Error query " + error.code + " : " + error.message);
       }});

    },
    error: function(error) {
      console.error("Error querying ratings " + error.code + ": " + error.message);
    }
  });
});
