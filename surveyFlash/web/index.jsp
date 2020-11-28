<%-- 
    Document   : index
    Created on : 28/11/2020, 02:08:00 PM
    Author     : julio.wong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="template/client/header.html" %>
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
        <image src="images/banner.jpg" />
    </div>
    <div class="carousel-item">
      <image src="images/banner.jpg" />
    </div>
    <div class="carousel-item">
     <image src="images/banner.jpg" />
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
    </body>
<%@include file="template/client/footer.html" %>
