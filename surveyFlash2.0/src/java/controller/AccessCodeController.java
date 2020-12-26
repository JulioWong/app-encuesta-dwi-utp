package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.context.FacesContext;
import model.AccessCode;
import model.DAO.AccessCodeDAO;

@Named(value = "accessCodeController")
@RequestScoped
public class AccessCodeController {

    private String firstName;
    private String lastName;
    private String document;
    private String email;
    private String cellphone;
    
    public AccessCodeController() {
    }
    
    public ArrayList<AccessCode> getAllCode(String surveyId) {
        AccessCodeDAO question = new AccessCodeDAO();
        return question.getAll(Integer.parseInt(surveyId));
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

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }
    
    public void checkParams() throws IOException {
        FacesContext fc = FacesContext.getCurrentInstance();
        Map<String, String> params = fc.getExternalContext().getRequestParameterMap();
        
        if (!params.containsKey("id")) {
            FacesContext.getCurrentInstance().getExternalContext()
            .redirect("./survey.xhtml");
        }
    }
    
    public void saveData() throws IOException {
        FacesContext fc = FacesContext.getCurrentInstance();
        Map<String, String> params = fc.getExternalContext().getRequestParameterMap();
        
        AccessCode accessCode = new AccessCode();
        AccessCodeDAO accessCodeDAO = new AccessCodeDAO();      
        accessCode.setSurveyId(Integer.parseInt(params.get("id")));
        accessCode.setFirstName(this.firstName);
        accessCode.setLastName(this.lastName);
        accessCode.setDocument(this.document);
        accessCode.setEmail(this.email);
        accessCode.setCellPhone(this.cellphone);
        accessCodeDAO.add(accessCode);
        this.redirect(params.get("id"));
    }
    
    public void delete(String accessCodeId) throws IOException {
        FacesContext fc = FacesContext.getCurrentInstance();
        Map<String, String> params = fc.getExternalContext().getRequestParameterMap();
        
        AccessCodeDAO accessCodeDAO = new AccessCodeDAO();
        accessCodeDAO.delete(Integer.parseInt(accessCodeId));
        this.redirect(params.get("id"));
    }
    
     private void redirect(String surveyId) throws IOException {
        FacesContext.getCurrentInstance().getExternalContext()
            .redirect("./access-code.xhtml?id=" + surveyId);
    }
}
