from django.shortcuts import render
from rest_framework import generics
from rest_framework.generics import GenericAPIView
from rest_framework import status
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from django.views import View

from eBoard_auth.serializer import *

# Create your views here.


class RegisterView(generics.CreateAPIView):

    """This View create an account for the user"""
    serializer_class = RegisterSerializer
    permission_classes = [permissions.AllowAny]

    def create(self, request, *args, **kwargs):
        """Creates a user"""
        super().create(request, *args, **kwargs)
        return Response(status=status.HTTP_201_CREATED)


class UserView(generics.RetrieveAPIView):
    """This view returns a user"""
    serializer_class = UserSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_object(self):
        return self.request.user


class AllNoticeView(generics.ListAPIView):
    """This view gets all driver request history"""
    serializer_class = AllNoticeSerializers
    permission_classes = (permissions.IsAuthenticated,)
    model = Notification
    queryset = Notification.objects.all()

    def get_queryset(self):
        receiver = ''
        user = self.request.user
        if user.is_lec:
            receiver = 'Staff'
        else:
            receiver = 'Student'

        try:
            return Notification.objects.filter(receiver__icontains=receiver).order_by('-date_created')
        except AttributeError:
            return None

class GetNoticeView(generics.RetrieveAPIView):
    """This view returns a notice request"""
    serializer_class = NoticeDetailSerializers
    permission_classes = (permissions.IsAuthenticated,)

    def get(self, request, note_id):
        try:
            note = Notification.objects.get(id=note_id)
            serializers = NoticeDetailSerializers(note)
            return Response(serializers.data)
        except Notification.DoesNotExist:
            return Response(status = status.HTTP_400_BAD_REQUEST)


class UpdateUserView(generics.UpdateAPIView):
    """This view returns a user"""
    serializer_class = UserSerializer
    queryset = User.objects.all()
    permission_classes = (permissions.IsAuthenticated,)

class ChangePasswordView(generics.UpdateAPIView):
    """This view updates the user password"""
    serializer_class = ChangePassSerializer
    queryset = User.objects.all()
    permission_classes = (permissions.IsAuthenticated,)

