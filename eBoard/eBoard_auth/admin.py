from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
import requests
import json

from eBoard_auth.models import (
    User,
    Notification,
)


class UserAdmin(UserAdmin):
    list_display = ('name', 'username', 'phone', 'is_lec', 'is_staff',
                    'is_superuser', 'date_joined', 'last_login', 'is_active',)
    search_fields = ('username', 'phone')
    ordering = ()
    readonly_fields = ('date_joined', 'last_login',)

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()


def send_sms(receiver):
    users = None
    if receiver == 'staff':
        users = User.objects.filter(is_lec=True)
    if receiver == 'student':
        users = User.objects.filter(is_lec=False, is_staff=False)
    if receiver == 'staff and student':
        users = User.objects.filter(is_staff=False)

    users_phone_number = []

    for user in users:
        users_phone_number.append(user.phone)

    users_phone_string = str(','.join(users_phone_number))

    url = "https://www.bulksmsnigeria.com/api/v2/sms"

    payload = {
        'from': 'eNotice',
        'to': users_phone_string,
        'body': 'A new notification has been posted on e-notice board. kindly login to the app to view.',
        'api_token': 'Pro7K2OnSaHGHc2tbwryMHJrUmfnivLyGKILbPjGcwRlWHVFXoIQ7pWQcKDq',
        'gateway': 'direct-refund'
    }
    files = []
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    }

    # response = requests.request(
    #     "POST", url, headers=headers, json=payload, files=files)


class NoticeAdmin(admin.ModelAdmin):

    list_display = ('title', 'receiver',
                    'description', 'date_created', 'created_by', 'image', 'file')
    search_fields = ('title', 'receiver')
    ordering = ('date_created',)
    raw_id_fields = ['created_by']

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()

    def save_model(self, request, obj, form, change):
        if not change:  # Check if the model is being created, not updated
            send_sms(obj.receiver)
        super().save_model(request, obj, form, change)


# Register your models here.
admin.site.register(User, UserAdmin)
# admin.site.register(Notification)
admin.site.register(Notification, NoticeAdmin)
