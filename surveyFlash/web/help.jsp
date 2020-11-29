<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="template/client/header.jsp" %>
<div class="container">
    <div style="display:flex;max-width: 280px;margin:10px auto auto auto;align-items: center;">
        <img src="assets/images/company1.jpg" width="100"/>
        <h6 style="font-size: 13px;font-weight: 600">ENCUESTA DE SATISFACCIÓN</h6>
    </div>
    <div class="text-center">
        Antes de empezar recuerda lo siguiente:
    </div>
    <div style="max-width: 300px;margin:auto">
        <div style="margin: 25px 0 0 0">
            <img src="assets/images/faces/0_active.svg"/>
            <span style="margin-left: 30px">Muy malo</span>
        </div>
        <div style="margin: 25px 0 0 0">
            <img src="assets/images/faces/1_active.svg"/>
            <span style="margin-left: 30px">Malo</span>
        </div>
        <div style="margin: 25px 0 0 0">
            <img src="assets/images/faces/2_active.svg"/>
            <span style="margin-left: 30px">Regular</span>
        </div>
        <div style="margin: 25px 0 0 0">
            <img src="assets/images/faces/3_active.svg"/>
            <span style="margin-left: 30px">Bueno</span>
        </div>
        <div style="margin: 25px 0 0 0">
            <img src="assets/images/faces/4_active.svg"/>
            <span style="margin-left: 30px">Muy Bueno</span>
        </div>
        <div class="text-center" style="margin: 45px 0 0 0">
            <a class="btn btn-primary" href="#" role="button">¡Estoy listo!</a>
        </div>
    </div>
</div>
<%@include file="template/client/footer.html" %>