package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.enterprise.context.ApplicationScoped;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import model.AccessCode;
import model.Company;
import model.DAO.AccessCodeDAO;
import model.DAO.CompanyDAO;

@Named
@ApplicationScoped
public class IndexController {
     
    private ArrayList<Company> allCompany;
    
    public IndexController() {
        CompanyDAO company = new CompanyDAO();
        allCompany = company.getAll();
    }

    public ArrayList<Company> getAllCompany() {
        return allCompany;
    }

    public void setAllCompany(ArrayList<Company> allCompany) {
        this.allCompany = allCompany;
    }
}
