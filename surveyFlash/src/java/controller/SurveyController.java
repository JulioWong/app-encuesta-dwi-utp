/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Company;
import model.DAO.SurveyDAO;
import model.Survey;


@WebServlet(name = "SurveyController", urlPatterns = {"/SurveyController"})
public class SurveyController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         
        boolean res = false;
        Survey survey = new Survey();
        SurveyDAO surveyDAO = new SurveyDAO();
        
        if (request.getParameter("surveyId").equals("0")) {
            survey.setDescription(request.getParameter("description"));
            survey.setDiscount(request.getParameter("discount"));
            survey.setBannerDiscount(request.getParameter("banner"));
            survey.setDiscountExpiration(request.getParameter("exp"));
            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("userId");
            Company company = (Company) session.getAttribute("company");
            res = surveyDAO.add(userId, survey, company);
            
        } else {
            survey.setSurveyId(Integer.parseInt(request.getParameter("surveyId")));
            survey.setDescription(request.getParameter("description"));
            survey.setDiscount(request.getParameter("discount"));
            survey.setBannerDiscount(request.getParameter("banner"));
            survey.setDiscountExpiration(request.getParameter("exp"));
            res = surveyDAO.update(survey);
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
