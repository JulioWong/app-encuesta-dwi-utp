package model.DAO;

import config.Database;
import interfaces.AnswerInterface;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Answer;

public class AnswerDAO implements AnswerInterface{
    
    Connection DBconnection= new Database().getConnection();
    Answer answer;

    @Override
    public int addAnswer(int accessCodeId, int surveyId) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spSetAnswer(?, ?)}");  
            proc.setInt(1, accessCodeId);
            proc.setInt(2, surveyId);
            proc.execute();
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {
                return rs.getInt("answerId");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
        return 0;
    }

    @Override
    public Boolean addDetail(int answerId, int questionId, int alternativeId, String answer, int score) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spSetAnswerDetail(?, ?, ?, ?, ?)}");  
            proc.setInt(1, answerId);
            proc.setInt(2, questionId);
            proc.setInt(3, alternativeId);
            proc.setString(4, answer);
            proc.setInt(5, score);
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public ArrayList<Answer> getAll(int surveyId) {
        ArrayList<Answer> allAnswer = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetOverviewAnswer(?)}");    
            proc.setInt(1, surveyId);
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {  
                answer = new Answer();
                answer.setQuestionId(rs.getString("questionId"));
                answer.setQuestion(rs.getString("question"));
                answer.setCountReplies(rs.getInt("countReplies"));
                allAnswer.add(answer); 
            }            
        } catch (SQLException ex) {
            Logger.getLogger(CompanyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allAnswer;
    }
    
}
