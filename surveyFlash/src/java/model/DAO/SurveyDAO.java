package model.DAO;

import config.Database;
import interfaces.SurveyInterface;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Company;
import model.Survey;

public class SurveyDAO implements SurveyInterface{
    
    Connection DBconnection= new Database().getConnection();
    Survey survey;
    
    @Override
    public ArrayList<Survey> getAll(Company company) {
        ArrayList<Survey> allSurvey = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetSurveys(?)}");  
            proc.setInt(1, company.getCompanyId());
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {  
                survey = new Survey();
                survey.setSurveyId(rs.getInt("surveyId"));
                survey.setDescription(rs.getString("description"));
                survey.setDiscount(rs.getString("discount"));
                survey.setBannerDiscount(rs.getString("bannerDiscount"));
                survey.setDiscountExpiration(rs.getString("timestampExpiration"));
                survey.setActive(rs.getString("active"));
                allSurvey.add(survey);
            }            
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allSurvey;
    }

    @Override
    public boolean add(int userId, Survey survey, Company company) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spInsSurvey(?, ?, ?, ?, ?, ?)}");  
            proc.setInt(1, company.getCompanyId());
            proc.setInt(2, userId);
            proc.setString(3, survey.getDescription());
            proc.setString(4, survey.getDiscount());
            proc.setString(5, survey.getBannerDiscount());
            proc.setString(6, survey.getDiscountExpiration());
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean update(Survey survey) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spUpdSurvey(?, ?, ?, ?, ?)}");  
            proc.setInt(1, survey.getSurveyId());
            proc.setString(2, survey.getDescription());
            proc.setString(3, survey.getDiscount());
            proc.setString(4, survey.getBannerDiscount());
            proc.setString(5, survey.getDiscountExpiration());
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
