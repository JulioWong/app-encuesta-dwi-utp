package model.DAO;

import config.Database;
import interfaces.QuestionInterface;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Question;

public class QuestionDAO implements QuestionInterface{
    
    Connection DBconnection= new Database().getConnection();
    Question question;

    @Override
    public ArrayList<Question> getAll(int surveyId) {
        ArrayList<Question> allQuestion = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetQuestions(?)}");  
            proc.setInt(1, surveyId);
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {  
                question = new Question();
                question.setQuestionId(rs.getInt("questionId"));
                question.setQuestion(rs.getString("question"));
                question.setTypeId(Integer.parseInt(rs.getString("typeQuestionId")));
                question.setType(rs.getString("typeQuestion"));
                question.setTimestampCreated(rs.getString("timestampCreated"));
                allQuestion.add(question);
            }            
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allQuestion;
    }

    @Override
    public boolean add(Question question) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spInsQuestion(?, ?, ?)}");
            proc.setInt(1, question.getSurveyId());
            proc.setInt(2, question.getTypeId());
            proc.setString(3, question.getQuestion());
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean update(Question question) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spUpdQuestion(?, ?, ?)}");
            proc.setInt(1, question.getQuestionId());
            proc.setInt(2, question.getTypeId());
            proc.setString(3, question.getQuestion());
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean delete(int questionId) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spDelQuestion(?)}");
            proc.setInt(1, questionId);
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
}
