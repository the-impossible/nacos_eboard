from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from eBoard_auth.models import (
    User,
    Notification,
)


class UserAdmin(UserAdmin):
    list_display = ('name', 'username', 'is_lec', 'is_staff',
                    'is_superuser', 'date_joined', 'last_login', 'is_active',)
    search_fields = ('username',)
    ordering = ()
    readonly_fields = ('date_joined', 'last_login',)
    # add_fieldsets = (
    #         (None, {'fields': ( 'name', 'username', 'password', 'is_lec',)}
    #     ),
    # )

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()


class NoticeAdmin(admin.ModelAdmin):

    list_display = ('title', 'receiver',
                    'description', 'date_created', 'created_by', 'image', 'file')
    search_fields = ('title', 'receiver')
    ordering = ('date_created',)
    raw_id_fields = ['created_by']

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()


# Register your models here.
admin.site.register(User, UserAdmin)
# admin.site.register(Notification)
admin.site.register(Notification, NoticeAdmin)
