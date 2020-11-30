<%@page import="model.TypeQuestion"%>
<%@page import="model.DAO.TypeQuestionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="template/admin/header.jsp" %>

<% 
    request.setCharacterEncoding("UTF-8");
    String title = request.getParameter("title");
%>

<div class="container">
   <br>
   
    <div class="row">
        <div class="col-sm-6">
            <h5>Preguntas <small>- <%=title%></small></h5>
        </div>
        <div class="col-sm-6 text-right">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalNewQuestion" data-id="0">
         Nueva pregunta 
         <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
           <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
           <path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
         </svg>
     </button>
        </div>
    </div>    
     <br>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">Pregunta</th>
                <th scope="col">Tipo</th>
                <th scope="col">Fecha</th>
                <th scope="col"></th>
              </tr>
            </thead>
            <tbody>
                <%@include file="./partialView/_listQuestion.jsp" %>
            </tbody>
      </table>
    </div>
</div>

<div class="modal" id="modalNewAlternatives" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modalNewQuestion" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <form class="asyncForm" method="POST" action="./QuestionController">
        <div class="modal-header">
          <h5 class="modal-title">Nueva pregunta</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <input type="hidden" name="surveyId" id="surveyId" value="<%=surveyId%>"/>
            <input type="hidden" name="questionId" id="questionId"/>
            <input type="hidden" name="type" id="new_edit"/>
            <div class="form-group">
              <label for="description">Pregunta</label>
              <input type="text" class="form-control" id="description" name="description" 
                    autocomplete="off" required>
            </div>
            <div class="form-group">
              <label for="discount">Tipo</label>
              <select class="form-control" id="typeId" id="typeId" name="typeId" required>
                  <option value="">Seleccione</option>
                  <%
                    TypeQuestionDAO typeQuestion = new TypeQuestionDAO();
                    ArrayList<TypeQuestion> allTypeQuestion = typeQuestion.getAll();
                    TypeQuestion typeQues;
                    for(int i=0; i < allTypeQuestion.size(); i++){
                        typeQues = new TypeQuestion();
                        typeQues = allTypeQuestion.get(i);
                    %>
                    <option value="<%=typeQues.getTypeQuestionId()%>">
                        <%=typeQues.getDescription()%></option>
                    <% } %>
              </select>
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
<script src="./assets/js/question.js"></script>
<%@include file="template/admin/footer.html" %>