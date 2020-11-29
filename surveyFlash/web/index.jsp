<%@page import="java.util.ArrayList"%>
<%@page import="model.Company"%>
<%@page import="model.DAO.CompanyDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="template/client/header.jsp" %>
<div id="carouselExampleIndicators" class="carousel slide" 
     data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#carouselExampleIndicators" data-slide-to="0" 
          class="active"></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item active">
          <img class="d-block w-100" src="assets/images/banner.jpg" />
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
  <br>
  <div class="container text-center">
      <h5>Recibe beneficios exclusivos</h5>
      <span>Con tu boleta recibirás un código de acceso. Realiza una breve 
          encuesta y ¡listo!</span>
      <form action="./help.jsp">
        <div class="form-group">
            <input type="text" name="code" class="form-control" 
                   style="max-width:500px;margin:auto;margin-top:10px" required>
        </div>
        <button type="submit" class="btn btn-primary">Empezar</button>
      </form>
  </div>
  <div class="container">
      
    <div class="row">
        <%
        CompanyDAO company = new CompanyDAO();
        ArrayList<Company> allCompany = company.getAll();
        Company comp;
        for(int i=0; i < allCompany.size(); i++){
            comp = new Company();
            comp = allCompany.get(i);
        %>
        <div class="col-sm-3">
            <div class="card" style="width: 18rem;">
                <img class="card-img-top" src="<%=comp.getLogo()%>" 
                     alt="Card image cap">
              <div class="card-body">
                  <h5 class="card-title"><%=comp.getDescription()%></h5>
                <a href="#" class="btn btn-primary">Ir a la tienda</a>
              </div>
            </div>
          </div>
        <%}%> 
    </div>
      
  </div>
<%@include file="template/client/footer.html" %>
