<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="template/admin/header.jsp" %>

<div class="container">
   <br>
    <div class="row">
        <div class="col-sm-6">
            <h5>Mis encuestas</h5>
        </div>
        <div class="col-sm-6 text-right">
            <button type="button" class="modalSurvey btn btn-primary" data-target="#modalNewSurvey" data-toggle="modal" data-id="0">
         Nueva encuesta 
         <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
           <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
           <path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
         </svg>
     </button>
        </div>
    </div>    
     <br>
    <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Descripción</th>
            <th scope="col">Descuento</th>
            <th scope="col">Expiración</th>
            <th scope="col">Activo</th>
            <th scope="col"></th>
          </tr>
        </thead>
        <tbody>
        <%@include file="partialView/_listSurvey.jsp" %>
        </tbody>
  </table>
</div>

<div class="modal" id="modalNewSurvey" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
        <form class="asyncForm" method="POST" action="./SurveyController">
            <div class="modal-header">
              <h5 class="modal-title">Nueva encuesta</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="surveyId" id="surveyId"/>
                <input type="hidden" name="type" id="new_edit"/>
                <div class="form-group">
                  <label for="description">Descripción</label>
                  <input type="text" class="form-control" id="description" name="description" required>
                </div>
                <div class="form-group">
                  <label for="discount">Descuento</label>
                  <input type="text" class="form-control" id="discount" name="discount" required>
                </div>
                <div class="form-group">
                  <label for="exp">Expiración del descuento</label>
                  <input type="date" class="form-control" id="exp" name="exp" required>
                </div>
                <div class="form-group">
                  <label for="banner">Banner del descuento</label>
                  <input type="text" class="form-control" id="banner" name="banner">
                </div>
            </div>
            <div class="modal-footer">
              <button type="submit" class="btn btn-primary">Guardar</button>
            </div>
        </form>
    </div>
  </div>
</div>
<script src="./assets/js/all.js"></script>
<script src="./assets/js/survey.js"></script>
<%@include file="template/admin/footer.html" %>