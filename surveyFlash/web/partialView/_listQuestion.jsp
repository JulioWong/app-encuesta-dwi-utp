<%@page import="model.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.DAO.QuestionDAO"%>
<%
QuestionDAO question = new QuestionDAO();
String surveyId = request.getParameter("id");
ArrayList<Question> allQuestion = question.getAll(Integer.parseInt(surveyId));
Question ques;
for(int i=0; i < allQuestion.size(); i++){
    ques = new Question();
    ques = allQuestion.get(i);
%>
    <tr>
        <td>
            <a href="#" data-target="#modalNewQuestion" data-toggle="modal" 
                data-id="<%=ques.getQuestionId()%>"
                data-description="<%=ques.getQuestion()%>"
                data-typeid="<%=ques.getTypeId()%>"
             >
                <%=ques.getQuestionId()%>
            </a>
        </th>
        <td><%=ques.getQuestion()%></td>
        <td><%=ques.getType()%></td>
        <td><%=ques.getTimestampCreated()%></td>
        <td>
             <div class="btn-group">
                <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  Opciones
                </button>
                <div class="dropdown-menu dropdown-menu-right">
                  <button class="dropdown-item" type="button" data-toggle="modal" data-target="#modalNewAlternatives">Alternativas</button>
                  <div class="dropdown-divider"></div>
                  
                    <form class="asyncForm" method="POST" action="./QuestionController">
                        <input type="hidden" name="questionId" value="<%=ques.getQuestionId()%>">
                        <input type="hidden" name="type" value="delete">
                        <button class="dropdown-item" type="submit">Eliminar</button>
                    </form>
                </div>
              </div>
        </td>
    </tr>
<% } %>