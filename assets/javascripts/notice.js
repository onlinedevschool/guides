$(document).ready(function(){
  $.get("ad.html").done(function(data) {
    $(".ad").html(data);
    console.debug("loaded html from ad.html");
    $(".schedule-link").on("click", function(e) {
      var s="I want to make more money and become a successful web developer!";
      document.location.href = "mailto:assessments@rubymentor.io?subject="+s;
    });
  });
});
