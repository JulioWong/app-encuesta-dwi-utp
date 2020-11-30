package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAO.QuestionDAO;
import model.Question;

@WebServlet(name = "QuestionController", urlPatterns = {"/QuestionController"})
public class QuestionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        boolean res = false;
        Question question = new Question();
        QuestionDAO questionDAO = new QuestionDAO();
        
        if (request.getParameter("type").equalsIgnoreCase("delete")) {
            res = questionDAO.delete(
                    Integer.parseInt(request.getParameter("questionId")));
            
        } else {
            if (request.getParameter("questionId").equals("0")) {
                question.setSurveyId(Integer.parseInt(request.getParameter("surveyId")));
                question.setQuestion(request.getParameter("description"));
                question.setTypeId(Integer.parseInt(request.getParameter("typeId")));
                res = questionDAO.add(question);
            } else {
                question.setQuestionId(Integer.parseInt(request.getParameter("questionId")));
                question.setQuestion(request.getParameter("description"));
                question.setTypeId(Integer.parseInt(request.getParameter("typeId")));
                res = questionDAO.update(question);
            }
        }
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(res);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
