package controller;

import java.io.IOException;
import java.io.Serializable;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Map;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;
import javax.faces.context.FacesContext;
import model.Alternative;
import model.DAO.AlternativeDAO;
import model.DAO.QuestionDAO;
import model.DAO.TypeQuestionDAO;
import model.Question;
import model.TypeQuestion;

@Named(value = "questionController")
@SessionScoped
public class QuestionController implements Serializable{
    
    private String questionId;
    private String description;
    private String typeId;
    private String descripcionAlternativa;

    public QuestionController() {
    }
    
    public ArrayList<Question> getAllQuestion(String surveyId) {
        QuestionDAO question = new QuestionDAO();
        return question.getAll(Integer.parseInt(surveyId));
    }
    
    public ArrayList<TypeQuestion> getAllTypeQuestion() {
        TypeQuestionDAO typeQuestion = new TypeQuestionDAO();
        return typeQuestion.getAll();
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String type) {
        this.typeId = type;
    }

    public String getDescripcionAlternativa() {
        return descripcionAlternativa;
    }

    public void setDescripcionAlternativa(String descripcionAlternativa) {
        this.descripcionAlternativa = descripcionAlternativa;
    }
    
    public void checkParams() throws IOException {
        FacesContext fc = FacesContext.getCurrentInstance();
        Map<String, String> params = fc.getExternalContext().getRequestParameterMap();
        
        if (!params.containsKey("id") || !params.containsKey("description")) {
            FacesContext.getCurrentInstance().getExternalContext()
            .redirect("./survey.xhtml");
        }
    }
    
    public void delete(String questionId) throws IOException {
        FacesContext fc = FacesContext.getCurrentInstance();
        Map<String, String> params = fc.getExternalContext().getRequestParameterMap();
        Question question = new Question();
        QuestionDAO questionDAO = new QuestionDAO();
        
        questionDAO.delete(Integer.parseInt(questionId));
        this.redirect(params.get("id"), params.get("description"));
    }
    
    public void saveData() throws IOException {
        Question question = new Question();
        QuestionDAO questionDAO = new QuestionDAO();
        FacesContext fc = FacesContext.getCurrentInstance();
        Map<String, String> params = fc.getExternalContext().getRequestParameterMap();

        if (this.questionId.equals("0")) {
            question.setSurveyId(Integer.parseInt(params.get("id")));
            question.setQuestion(this.description);
            question.setTypeId(Integer.parseInt(this.typeId));
            questionDAO.add(question);

        } else {
            question.setQuestionId(Integer.parseInt(this.questionId));
            question.setQuestion(this.description);
            question.setTypeId(Integer.parseInt(this.typeId));
            questionDAO.update(question);
        }
        this.redirect(params.get("id"), params.get("description"));
    }
    
    private void redirect(String surveyId, String description) throws IOException {
        FacesContext.getCurrentInstance().getExternalContext()
            .redirect("./question.xhtml?id=" + surveyId + "&description=" + 
                URLEncoder.encode(description, java.nio.charset.StandardCharsets.UTF_8.toString()));
    }
    
    public ArrayList<Alternative> getAllAlternatives() {
        ArrayList<Alternative> data = new ArrayList<>();
        if (this.questionId != null) {
            AlternativeDAO alternative = new AlternativeDAO();
            data = alternative.getAll(Integer.parseInt(this.questionId));
        }
        return data;
    }
    
    public void saveAlternative() {
        Alternative alternative = new Alternative();
        AlternativeDAO alternativeDAO = new AlternativeDAO();
        
        alternative.setQuestionId(Integer.parseInt(this.questionId));
        alternative.setDescription(this.descripcionAlternativa);
        alternativeDAO.add(alternative);
    }
    
    public void deleteAlternative(String alternativeId) {
        AlternativeDAO alternativeDAO = new AlternativeDAO();
        Boolean a = alternativeDAO.delete(Integer.parseInt(alternativeId));
        System.out.println(a);
    }
}
