package controller;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.context.FacesContext;
import model.AccessCode;
import model.Alternative;
import model.DAO.AccessCodeDAO;
import model.DAO.AlternativeDAO;
import model.DAO.AnswerDAO;
import model.DAO.QuestionDAO;
import model.DAO.SurveyDAO;
import model.Question;
import model.Survey;

@Named(value = "applicationController")
@SessionScoped
public class ApplicationController implements Serializable{

    private String errorMessage;
    private String code;
    private int accessCodeId;
    private String firstName;
    private String lastName;
    
    private int surveyId;
    private String descriptionSurvey;
    private String discountSurvey;
    private String expirationDiscountSurvey;
    private String bannerDiscount;
    private String logo;
    
    private int questionId;
    private int answerId;
    private int countQuestion;
    private int currentQuestion = 0;
    private String question;
    private String typeQuestion;
    private ArrayList<String> alternativeSelected = new ArrayList<>();
    private int score;
    private String answerText;
    
    public ApplicationController() {
    }
    
    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getDescriptionSurvey() {
        return descriptionSurvey;
    }

    public void setDescriptionSurvey(String descriptionSurvey) {
        this.descriptionSurvey = descriptionSurvey;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getCountQuestion() {
        return countQuestion;
    }

    public void setCountQuestion(int countQuestion) {
        this.countQuestion = countQuestion;
    }

    public int getCurrentQuestion() {
        return currentQuestion;
    }

    public void setCurrentQuestion(int currentQuestion) {
        this.currentQuestion = currentQuestion;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getTypeQuestion() {
        return typeQuestion;
    }

    public void setTypeQuestion(String typeQuestion) {
        this.typeQuestion = typeQuestion;
    }

    public int getAccessCodeId() {
        return accessCodeId;
    }

    public void setAccessCodeId(int accessCodeId) {
        this.accessCodeId = accessCodeId;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public ArrayList<String> getAlternativeSelected() {
        return alternativeSelected;
    }

    public void setAlternativeSelected(ArrayList<String> alternativeSelected) {
        this.alternativeSelected = alternativeSelected;
    }

    public String getAnswerText() {
        return answerText;
    }

    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    public String getDiscountSurvey() {
        return discountSurvey;
    }

    public void setDiscountSurvey(String discountSurvey) {
        this.discountSurvey = discountSurvey;
    }

    public String getExpirationDiscountSurvey() {
        return expirationDiscountSurvey;
    }

    public void setExpirationDiscountSurvey(String expirationDiscountSurvey) {
        this.expirationDiscountSurvey = expirationDiscountSurvey;
    }

    public String getBannerDiscount() {
        return bannerDiscount;
    }

    public void setBannerDiscount(String bannerDiscount) {
        this.bannerDiscount = bannerDiscount;
    }
    
    
    
    public void accessSurvey() throws IOException {
        AccessCodeDAO accessDAO = new AccessCodeDAO();
        AccessCode access = accessDAO.verify(this.code);
        if (access.getAccessCodeId() > 0) {
            this.clear();
            this.accessCodeId = access.getAccessCodeId();
            this.surveyId = access.getSurveyId();
            this.firstName = access.getFirstName();
            this.lastName = access.getLastName();
            
            SurveyDAO surveyDAO = new SurveyDAO();
            Survey survey = surveyDAO.get(this.surveyId);
            
            this.logo = survey.getLogo();
            this.descriptionSurvey = survey.getDescription().toUpperCase();
            this.countQuestion = survey.getCountQuestion();
            this.discountSurvey = survey.getDiscount();
            this.expirationDiscountSurvey = survey.getDiscountExpiration();
            this.bannerDiscount = survey.getBannerDiscount();
                    
            this.redirect("./help.xhtml");
            this.errorMessage = "";
        } else {
            this.errorMessage = "Número de documento no válido";
        }
    }
    
    private void redirect(String path) throws IOException {
        FacesContext.getCurrentInstance().getExternalContext()
            .redirect(path);
    }
    
    public void checkAlreadyVerify() throws IOException {
        if (this.surveyId == 0) {
            this.redirect("./");
        }
    }
    
    public int progress() {
        return (this.currentQuestion * 100) / this.countQuestion;
    }
    
    public void init() throws IOException {
        QuestionDAO questionDAO = new QuestionDAO();
        Question ques = questionDAO.getCurrent(this.surveyId, this.currentQuestion);
        
        AnswerDAO answerDAO = new AnswerDAO();
        this.answerId = answerDAO.addAnswer(this.accessCodeId, this.surveyId);
        this.questionId = ques.getQuestionId();
        this.question = ques.getQuestion();
        this.typeQuestion = ques.getType();
        
        if (this.currentQuestion < this.countQuestion) {
            this.redirect("./step.xhtml");
        } else {
            this.redirect("./finish.xhtml");
        }
    }
    
    public void nextQuestion() throws IOException {
        AnswerDAO answerDAO = new AnswerDAO();
        
        if (this.typeQuestion.equalsIgnoreCase("score")) {
            answerDAO.addDetail(this.answerId, this.questionId, 0, "", this.score);
            
        } else if (this.typeQuestion.equalsIgnoreCase("checkbox")) {
            for (int i = 0; i < this.alternativeSelected.size(); i++) {
                answerDAO.addDetail(this.answerId, this.questionId, 
                        Integer.parseInt(this.alternativeSelected.get(i)), "", 0);
            }
        } else if (this.typeQuestion.equalsIgnoreCase("text")) {
            answerDAO.addDetail(this.answerId, this.questionId, 0, this.answerText, 0);
        }
        
        this.currentQuestion++;
        this.init();
    }
    
    public ArrayList<Alternative> getAlternatives() {
        AlternativeDAO alternativeDAO = new AlternativeDAO();
        return alternativeDAO.get(this.questionId);
    }
    
    public void clear() {
        this.errorMessage = null;
        this.code = null;
        this.surveyId = 0;
        this.accessCodeId = 0;
        this.firstName = null;
        this.lastName = null;
        this.logo = null;
        this.descriptionSurvey = null;
        this.questionId = 0;
        this.answerId = 0;
        this.countQuestion = 0;
        this.currentQuestion = 0;
        this.question = null;
        this.typeQuestion = null;
        this.alternativeSelected = new ArrayList<>();
        this.score = 0;
        this.answerText = null;
    }
}
