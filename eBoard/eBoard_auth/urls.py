from django.urls import path

from eBoard_auth.views import *

from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenBlacklistView,
)

app_name = "auth"

urlpatterns = [
    path('login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('logout/', TokenBlacklistView.as_view(), name='token_blacklist'),

    path('register/', RegisterView.as_view(), name='register'),
    path('getUser/', UserView.as_view(), name='getUser'),

    path('allNotice/', AllNoticeView.as_view(), name='allNotice'),
    path('getNotice/<str:note_id>', GetNoticeView.as_view(), name='getNotice'),
    path("updateProfile/<str:pk>", UpdateUserView.as_view(), name="updateProfile"),

    path("changePassword/<str:pk>", ChangePasswordView.as_view(), name="changePassword"),

]
