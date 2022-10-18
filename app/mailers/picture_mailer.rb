class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture

    mail to: @picture.user.email, subject: "画像の投稿メール"
  end
end
