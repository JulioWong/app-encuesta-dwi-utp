<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="template/client/header.jsp" %>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-5">
            <div id="carouselExampleIndicators" class="carousel slide" 
                data-ride="carousel">
               <ol class="carousel-indicators">
                 <li data-target="#carouselExampleIndicators" data-slide-to="0" 
                     class="active"></li>
               </ol>
               <div class="carousel-inner">
                 <div class="carousel-item active">
                     <img class="d-block w-100" src="assets/images/banner2.jpg" />
                 </div>
               </div>
               <a class="carousel-control-prev" href="#carouselExampleIndicators" 
                  role="button" data-slide="prev">
                 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                 <span class="sr-only">Previous</span>
               </a>
               <a class="carousel-control-next" href="#carouselExampleIndicators" 
                  role="button" data-slide="next">
                 <span class="carousel-control-next-icon" aria-hidden="true"></span>
                 <span class="sr-only">Next</span>
               </a>
             </div>
        </div>
        <div class="col-sm-6">
            <div class="container">
                <br>
            <form id="formLogin" method="POST" action="./LoginController">
                <div class="form-group">
                    <p class="h4">Administra tus encuestas</p>
                </div>
                <div id="alertLogin" class="alert alert-danger" role="alert" style="display:none"></div>
                <div class="form-group">
                  <label for="email">Correo electrónico</label>
                  <input type="email" id="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                  <label for="password">Contraseña</label>
                  <input type="password" class="form-control" name="password" id="password" required>
                </div>
                <button type="submit" class="btn btn-primary">Iniciar sesión</button>
              </form>
            </div>
        </div>
    </div>
</div>
<script src="./assets/js/login.js"></script>
<%@include file="template/client/footer.html" %>