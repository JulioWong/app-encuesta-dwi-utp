package controller;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.context.FacesContext;
import model.Company;
import model.DAO.SurveyDAO;
import model.Survey;

@Named
@RequestScoped
public class SurveyController implements Serializable{
    
    private String surveyId;
    private String active;
    private String description;
    private String discount;
    private String exp;
    private String banner;
    
    public SurveyController() {
        
    }

    public ArrayList<Survey> getAllSurvey(Company comp) {
        SurveyDAO survey = new SurveyDAO();
        return survey.getAll(comp);
    }
    
    public ArrayList getButtonInfo(String textActive) {
        ArrayList buttonInfo = new ArrayList();
        if (textActive.equalsIgnoreCase("Si")) {
            buttonInfo.add(0);
            buttonInfo.add("Desactivar");
            
        } else {
            buttonInfo.add(1);
            buttonInfo.add("Activar");
        }
        return buttonInfo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getExp() {
        return exp;
    }

    public void setExp(String exp) {
        this.exp = exp;
    }

    public String getBanner() {
        return banner;
    }

    public void setBanner(String banner) {
        this.banner = banner;
    }

    public String getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(String surveyId) {
        this.surveyId = surveyId;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }
    
    public void saveData(int userId, Company company) throws IOException {
        Survey survey = new Survey();
        SurveyDAO surveyDAO = new SurveyDAO();
        
        if (this.surveyId.equals("0")) {
            survey.setDescription(this.description);
            survey.setDiscount(this.discount);
            survey.setBannerDiscount(this.banner);
            survey.setDiscountExpiration(this.exp);
            surveyDAO.add(userId, survey, company);

        } else {
            survey.setSurveyId(Integer.parseInt(this.surveyId));
            survey.setDescription(this.description);
            survey.setDiscount(this.discount);
            survey.setBannerDiscount(this.banner);
            survey.setDiscountExpiration(this.exp);
            surveyDAO.update(survey);
        }
        this.redirect();
    }
    
    public void allow(Company company, String surveyId, String active) throws IOException {
        SurveyDAO surveyDAO = new SurveyDAO();
        surveyDAO.active(
            Integer.parseInt(surveyId), 
            company.getCompanyId(),
            Integer.parseInt(active));
        this.redirect();
    }
    
    private void redirect() throws IOException {
        FacesContext.getCurrentInstance().getExternalContext()
            .redirect("./survey.xhtml");
    }
}
