package controller;

import java.io.IOException;
import java.io.Serializable;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.context.FacesContext;
import model.Company;
import model.DAO.UserDAO;
import model.User;

@Named
@SessionScoped
public class SessionController implements Serializable{
    
    private String email;
    private String password;
    private int userId;
    private Company company;
    private String error;

    public SessionController() throws IOException {
        
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
    
    public void iniciarSesion() throws IOException {
        if (this.userId == 0) {
            this.error = null;
            UserDAO user = new UserDAO();
            User u = user.login(this.email, this.password);

            if(u.getUserid() == 0) {
                this.error = "El usuario o contraseña son incorrectos." + this.userId;
            } else {
                this.userId = u.getUserid();
                this.company = u.getCompany();
                this.redirect();
            }
            
        } else {
            this.redirect();
        }
    }
    
    private void redirect() throws IOException {
        FacesContext.getCurrentInstance().getExternalContext()
                        .redirect("survey.xhtml");
    }
    
    public void cerrarSesion() {
        this.userId = 0;
        this.company = null;
        this.error = null;
        this.email = null;
        this.password = null;
    }
    
    public void checkAlreadyLoggedin() throws IOException {
        if(this.userId > 0) this.redirect();
    }
    
    public void checkNotLoggedin() throws IOException {
        if(this.userId == 0) 
            FacesContext.getCurrentInstance().getExternalContext()
                        .redirect("./login.xhtml");
    }
}
