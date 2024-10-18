---
permalink: /
title: "ABOUT ME"
excerpt: "About me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
<style> body {text-align: justify} </style> <!-- Justify text. -->

I am a post-doctoral researcher at <a href="https://geolab.uca.fr/" target="_blank" style="color:#3B528B;">CNRS – UMR GEOLAB</a> working on the structure of ecological networks and environmental gradients in wetlands. <br> 

<b>My research addresses fundamental questions at the interface of community ecology, macroecology and conservation biology. I aim to understand and predict the effects of global change on biodiversity and ecosystems, with a view to leveraging this knowledge for effective conservation and management.</b>
I investigate these questions by combining open-access databases on environmental, trait, trophic interaction, and phylogenetic characteristics, data from the field or from experiments, and statistical modelings to integrate and synthesize data across various spatial and temporal scales. Most of this work focuses on islands or island-like ecosystems (e.g. lakes). <br>

You can take a look at my <a href="https://camilleleclerc.github.io/research/" target="_blank" style="color:#3B528B;">research interests</a> and my <a href="https://camilleleclerc.github.io/publications/" target="_blank" style="color:#3B528B;">publications</a>. <br> <br>
  
  
For more information about my research experience, please see my <a href="https://camilleleclerc.github.io/cv/" target="_blank" style="color:#3B528B;">curriculum vitæ</a>. <br>
Feel free to contact me for any inquiries or potential collaborations in any research topic. 
You can reach me at <a href="mailto:camille.leclerc@uca.fr" target="_blank" style="color:#3B528B;">camille.leclerc[at]uca.fr</a>.  <br> <br>
  
  
*Key words:*<br>
biogeography ; community ecology ; conservation biology ; food-web ecology ; global changes ; macroecology ; multiple facets of biodiversity ; vulnerability assessment <br>
 <br>

<div class="slideshow-container">

<center>

<div class="mySlides fade">
  <img src="/images/wordcloud_google_scholar.png" style="width:60%">
  <div class="text"><font size = '3.5' color = "#000000">My Google Scholar Word Cloud. Make your own <a href="https://shiny.rcg.sfu.ca/u/rdmorin/scholar_googler2/" target="_blank" style="color:#3B528B;">here</a></font></div>
</div>

<div class="mySlides fade">
  <img src="/images/collaborations.png" style="width:60%">
  <div class="text"><font size = '3.5' color = "#000000">Overview of my collaborations.</font></div>
</div>

</center>

<a class="prev" onclick="plusSlides(-1)">❮</a>
<a class="next" onclick="plusSlides(1)">❯</a>

</div>

<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span> 
  <span class="dot" onclick="currentSlide(2)"></span> 
</div>

<script>
let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}
</script>
<br>

<img class="wp-image-817" style="width:340px;" src="images/logo_institut.png" alt="logo_institut" class="inline"/>

