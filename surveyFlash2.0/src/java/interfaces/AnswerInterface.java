package interfaces;

import java.util.ArrayList;
import model.Answer;

public interface AnswerInterface {
    public int addAnswer(int accessCodeId, int surveyId);
    public Boolean addDetail(int answerId, int questionId, 
            int alternativeId, String answer, int score);
    public ArrayList<Answer> getAll(int surveyId);
    
}
