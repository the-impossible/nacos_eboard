from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from eBoard_auth.models import (
    User,
)

class UserAdmin(UserAdmin):
    list_display = ('name', 'username', 'is_lec', 'is_staff', 'is_superuser', 'date_joined', 'last_login', 'is_active',)
    search_fields = ('username',)
    ordering = ()
    readonly_fields = ('date_joined', 'last_login',)
    add_fieldsets = (
            (None, {'fields': ( 'name', 'is_staff', 'is_superuser',)}
        ),
    )

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()

# Register your models here.
admin.site.register(User, UserAdmin)