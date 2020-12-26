package model;

public class Survey {
   private int surveyId;
   private String description;
   private String discount;
   private String bannerDiscount;
   private String discountExpiration;
   private String active;
   private String logo;
   private int countQuestion;

    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getBannerDiscount() {
        return bannerDiscount;
    }

    public void setBannerDiscount(String bannerDiscount) {
        this.bannerDiscount = bannerDiscount;
    }

    public String getDiscountExpiration() {
        return discountExpiration;
    }

    public void setDiscountExpiration(String discountExpiration) {
        this.discountExpiration = discountExpiration;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public int getCountQuestion() {
        return countQuestion;
    }

    public void setCountQuestion(int countQuestion) {
        this.countQuestion = countQuestion;
    }
   
    
}
