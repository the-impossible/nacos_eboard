# Django Imports
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from django.core.files.storage import default_storage
from geopy.distance import geodesic


import base64
# My App Import
from RD_auth.models import *

class RegisterSerializer(serializers.ModelSerializer):

    """Serializes the User model"""

    username = serializers.CharField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all(), message='Username Already Exist')]
    )

    class Meta:
        """Meta for the UserSerializer"""
        model = User
        fields = ['user_id', 'name', 'email', 'phone', 'password', 'is_mec']

    def create(self, validated_data):

        user = User.objects.create_user(
            validated_data['email'],
            validated_data['name'],
            validated_data['phone'],
            validated_data['is_mec'],
            validated_data['password']
        )

        user.save()

        return user

class UserSerializer(serializers.ModelSerializer):

    """Serializes the User model"""

    image = serializers.SerializerMethodField("get_image")

    class Meta:
        """Meta for the UserSerializer"""
        model = User
        fields = ['user_id', 'email', 'name', 'phone', 'is_mec', 'biz_name', 'shop_address', 'lat', 'lon', 'image']


    def get_image(self, user:User):
        """IMAGE"""
        file = default_storage.open(user.pic.name, 'rb')
        data = file.read()
        file.close()
        return base64.b64encode(data)

class EditUserSerializer(serializers.ModelSerializer):

    """Serializes the User model"""

    image = serializers.SerializerMethodField("get_image")

    class Meta:
        """Meta for the UserSerializer"""
        model = User
        fields = ['user_id', 'email', 'name', 'phone', 'is_mec', 'biz_name', 'shop_address','lat', 'lon', 'pic', 'image']

    def get_image(self, user:User):
        """IMAGE"""
        file = default_storage.open(user.pic.name, 'rb')
        data = file.read()
        file.close()
        return base64.b64encode(data)

class AllMecSerializers(serializers.ModelSerializer):
    """_MecSerializer_

    Args:
        serializers (_type_): _Serializing the User model to for API calls_
    """

    image = serializers.SerializerMethodField("get_image")
    distance = serializers.SerializerMethodField("cal_distance")

    class Meta:
        """Meta for the AllMecSerializer"""
        model = User
        fields = ['user_id', 'email', 'name', 'phone', 'is_mec', 'biz_name', 'shop_address','lat', 'lon', 'distance', 'image']

    def get_image(self, user:User):
        """IMAGE"""
        file = default_storage.open(user.pic.name, 'rb')
        data = file.read()
        file.close()
        return base64.b64encode(data)

    def cal_distance(self, mec_object):
        # Get current registered mechanic geo-coordinate
        m_lat = getattr(mec_object, "lat")
        m_lon = getattr(mec_object, "lon")

        # Get the current driver geo-coordinate
        d_lat = self.context['geo_data']['lat']
        d_lon = self.context['geo_data']['lon']

        # Organize the coordinate
        mec_coordinate = (m_lat, m_lon)
        driver_coordinate = (d_lat, d_lon)

        return f"{geodesic(driver_coordinate, mec_coordinate).km: .2f}".strip()

    def get_distance(self, instance):
        distance = instance.distance.order_by()

class RequestAMecSerializer(serializers.ModelSerializer):
    class Meta:
        """Meta for the RequestAMecSerializer"""
        model = RequestMec
        fields = ['request_id', 'mec_id', 'driver_id', 'lat', 'lon', 'approved', 'pending', 'date_requested']

class VerifyPendingRequestSerializer(serializers.ModelSerializer):

    class Meta:
        """Meta for the RequestAMecSerializer"""
        model = RequestMec
        fields = ['approved', 'pending', 'date_requested']

class AllRequestSerializer(serializers.ModelSerializer):

    distance = serializers.SerializerMethodField("cal_distance")
    biz_name = serializers.SerializerMethodField("get_biz_name")

    class Meta:
        """Meta for the RequestAMecSerializer"""
        model = RequestMec
        fields = ['request_id', 'biz_name', 'distance']

    def cal_distance(self, request_object):
        # Get the current driver geo-coordinate
        d_lat = getattr(request_object, "lat")
        d_lon = getattr(request_object, "lon")

        # Get current registered mechanic geo-coordinate
        mec = User.objects.get(email=getattr(request_object, 'mec_id'))

        m_lat = mec.lat
        m_lon = mec.lon

        # Organize the coordinate
        mec_coordinate = (m_lat, m_lon)
        driver_coordinate = (d_lat, d_lon)

        return f"{geodesic(driver_coordinate, mec_coordinate).km: .2f}".strip()

    def get_biz_name(self, request_object):
        # Get the current mechanic biz name
        print(f"CHECK3: {getattr(request_object, 'mec_id')}")
        mec = User.objects.get(email=getattr(request_object, 'mec_id'))

        return f"{mec.biz_name}".strip()
