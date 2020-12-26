package interfaces;

import java.util.ArrayList;
import model.Alternative;

public interface AlternativeInterface {
    public ArrayList<Alternative> get(int questionId);
    public ArrayList<Alternative> getAll(int questionId); 
    public boolean add(Alternative alternative);
    public boolean delete(int alternativeId);
}
