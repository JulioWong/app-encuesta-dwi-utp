<%@page import="model.Company"%>
<%@page import="model.Survey"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.DAO.SurveyDAO"%>
    <%
    SurveyDAO survey = new SurveyDAO();
    Company comp = (Company) session.getAttribute("company");
    ArrayList<Survey> allSurvey = survey.getAll(comp);
    Survey surv;
    for(int i=0; i < allSurvey.size(); i++){
    surv = new Survey();
    surv = allSurvey.get(i);
    %>
  <tr>
    <td scope="row">
        <a href="#" data-target="#modalNewSurvey" data-toggle="modal" 
           data-id="<%=surv.getSurveyId()%>"
           data-description="<%=surv.getDescription()%>"
           data-discount="<%=surv.getDiscount()%>"
           data-banner="<%=surv.getBannerDiscount()%>"
           data-exp="<%=surv.getDiscountExpiration()%>"
        >
            <%=surv.getSurveyId()%>
        </a>
    </td>
    <td><%=surv.getDescription()%></td>
    <td><%=surv.getDiscount()%></td>
    <td><%=surv.getDiscountExpiration()%></td>
    <td><%=surv.getActive()%></td>
    <td>
        <div class="btn-group">
            <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Opciones
            </button>
            <div class="dropdown-menu dropdown-menu-right">
              <a class="dropdown-item" 
                 href="./question.jsp?id=<%=surv.getSurveyId()%>&title=<%=surv.getDescription()%>"
              >Preguntas</a>
              <a class="dropdown-item" href="./answer.jsp?id=<%=surv.getSurveyId()%>">Respuestas</buttoan>
              <a class="dropdown-item" href="./access-code.jsp?id=<%=surv.getSurveyId()%>">Códigos de acceso</a>
              <div class="dropdown-divider"></div>
              <form class="asyncForm" method="POST" action="./SurveyController">
                  <input type="hidden" name="type" value="active">
                  <input type="hidden" name="surveyId" value="<%=surv.getSurveyId()%>">
                  <%
                    String textActive;
                    int active;
                    if (surv.getActive().equalsIgnoreCase("Si")) {
                        active = 0;
                        textActive = "Desactivar";
                    } else {
                        active = 1;
                        textActive = "Activar";
                    }
                  %>
                  <input type="hidden" name="active" value="<%=active%>">
                  <button class="itemOption dropdown-item" type="submit"><%=textActive%></button>
              </form>
            </div>
          </div>
    </td>
  </tr>
  <%}%> 
