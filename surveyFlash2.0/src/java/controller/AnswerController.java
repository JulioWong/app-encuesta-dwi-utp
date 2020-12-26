package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.context.FacesContext;
import model.Answer;
import model.DAO.AnswerDAO;

@Named(value = "answerController")
@RequestScoped
public class AnswerController {
    
    private int questionId;

    public AnswerController() {
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }
    
    public void checkParams() throws IOException {
        FacesContext fc = FacesContext.getCurrentInstance();
        Map<String, String> params = fc.getExternalContext().getRequestParameterMap();
        
        if (!params.containsKey("id")) {
            FacesContext.getCurrentInstance().getExternalContext()
            .redirect("./survey.xhtml");
        }
    }
    
    public ArrayList<Answer> getAll(String surveyId) {
        AnswerDAO answer = new AnswerDAO();
        return answer.getAll(Integer.parseInt(surveyId));
    } 
}
