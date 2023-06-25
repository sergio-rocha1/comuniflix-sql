document.addEventListener("DOMContentLoaded", function() {
    var gif = document.getElementById("gif");
    gif.addEventListener("animationend", function() {
        gif.style.visibility = "hidden";
    });
});
