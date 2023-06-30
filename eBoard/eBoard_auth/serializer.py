# Django Imports
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from django.core.files.storage import default_storage
import base64

# My App Import
from eBoard_auth.models import *


class RegisterSerializer(serializers.ModelSerializer):

    """Serializes the User model"""

    username = serializers.CharField(
        required=True,
        validators=[UniqueValidator(
            queryset=User.objects.all(), message='Username Already Exist')]
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


class NoticeDetailSerializers(serializers.ModelSerializer):
    """_AllNoticeSerializers_

    Args:
        serializers (_type_): _Serializing the User model to for API calls_
    """
    img = serializers.SerializerMethodField("get_image")
    docs = serializers.SerializerMethodField("get_file")

    class Meta:
        """Meta for the AllMecSerializer"""
        model = Notification
        fields = ['id', 'title', 'description',
                  'date_created', 'img', 'docs', 'created_by', 'file']

    def get_image(self, user: Notification):
        """IMAGE"""
        file = default_storage.open(user.image.name, 'rb')
        data = file.read()
        file.close()
        return base64.b64encode(data)

    def get_file(self, user: Notification):
        """IMAGE"""
        print(f"VERIFYING: {user.file.url}")
        print(f"VERIFYING: {user.file.path}")
        file = default_storage.open(user.file.name, 'rb')
        data = file.read()
        file.close()
        return base64.b64encode(data)



class ChangePassSerializer(serializers.ModelSerializer):

    """Changes the User Password"""

    password0 = serializers.CharField(
        required=True,
        write_only=True,
    )
    password1 = serializers.CharField(
        required=True,
        write_only=True,
    )
    password2 = serializers.CharField(
        required=True,
        write_only=True,
    )

    def validate(self, attrs):
        if attrs['password1'] != attrs['password2']:
            raise serializers.ValidationError(({"password":"Password fields didn't match!"}))

        return attrs

    def validate_password0(self, value):
        user = self.context['request'].user
        if not user.check_password(value):
            raise serializers.ValidationError({"password0":"Old password is incorrect!"})
        return value

    def update(self, instance, validated_data):
        instance.set_password(validated_data['password1'])
        instance.save()
        return instance

    class Meta:
        """Meta for the UserSerializer"""
        model = User
        fields = ['password0','password1','password2']
