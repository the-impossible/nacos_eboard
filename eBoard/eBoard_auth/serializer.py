# Django Imports
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
import base64

# My App Import
from eBoard_auth.models import *

class RegisterSerializer(serializers.ModelSerializer):

    """Serializes the User model"""

    username = serializers.CharField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all(), message='Username Already Exist')]
    )

    class Meta:
        """Meta for the UserSerializer"""
        model = User
        fields = ['user_id', 'username', 'name', 'is_lec', 'password']

    def create(self, validated_data):

        user = User.objects.create_user(
            validated_data['username'],
            validated_data['name'],
            validated_data['is_lec'],
            validated_data['password']
        )

        user.save()

        return user

class UserSerializer(serializers.ModelSerializer):

    """Serializes the User model"""

    class Meta:
        """Meta for the UserSerializer"""
        model = User
        fields = ['user_id', 'username', 'name', 'is_lec']


class AllNoticeSerializers(serializers.ModelSerializer):
    """_AllNoticeSerializers_

    Args:
        serializers (_type_): _Serializing the User model to for API calls_
    """

    class Meta:
        """Meta for the AllMecSerializer"""
        model = Notification
        fields = ['id', 'title', 'description', 'date_created']

    # img = serializers.SerializerMethodField("get_image")

    # def get_image(self, request_object):
    #     """IMAGE"""

    #     img = Notification.objects.get(image=getattr(request_object, 'image'))
    #     file = default_storage.open(img.name, 'rb')
    #     data = file.read()
    #     file.close()
    #     return base64.b64encode(data)


# class EditUserSerializer(serializers.ModelSerializer):

#     """Serializes the User model"""

#     image = serializers.SerializerMethodField("get_image")

#     class Meta:
#         """Meta for the UserSerializer"""
#         model = User
#         fields = ['user_id', 'email', 'name', 'phone', 'is_mec', 'biz_name', 'shop_address','lat', 'lon', 'pic', 'image']

#     def get_image(self, user:User):
#         """IMAGE"""
#         file = default_storage.open(user.pic.name, 'rb')
#         data = file.read()
#         file.close()
#         return base64.b64encode(data)

# class RequestAMecSerializer(serializers.ModelSerializer):
#     class Meta:
#         """Meta for the RequestAMecSerializer"""
#         model = RequestMec
#         fields = ['request_id', 'mec_id', 'driver_id', 'lat', 'lon', 'approved', 'pending', 'date_requested']
