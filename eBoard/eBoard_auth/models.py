from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager
import uuid
# Create your models here.


class UserManager(BaseUserManager):
    """ Extending the BaseUserManager"""

    def create_user(self, username, name, is_lec=None, password=None):
        """Creates a user account"""

        # creates a user with the parameters
        if not username:
            raise ValueError('Username is required!')

        if not name:
            raise ValueError('Fullname is required!')

        if password is None:
            raise ValueError('Password is required!')

        if is_lec is None:
            raise ValueError('Account Type is required!')

        user = self.model(
            username=username.lower().strip(),
            name=name.title().strip(),
            is_lec=is_lec,

        )

        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, username, name, password=None):
        """Creates a superuser account"""

        user = self.create_user(
            username=username,
            name=name,
            is_lec=False,
            password=password
        )

        user.is_staff = True
        user.is_superuser = True
        user.is_active = True
        user.save(using=self._db)

        return user


class User(AbstractBaseUser, PermissionsMixin):
    """Creates a User"""
    user_id = models.UUIDField(
        default=uuid.uuid4, primary_key=True, unique=True, editable=False)
    name = models.CharField(max_length=100)
    username = models.CharField(max_length=100, unique=True, db_index=True)
    is_lec = models.BooleanField(default=False)

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    date_joined = models.DateTimeField(
        verbose_name='date_joined', auto_now_add=True)
    last_login = models.DateTimeField(
        verbose_name='last_login', auto_now=True, null=True)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['name',]

    objects = UserManager()

    def __str__(self):
        return f'{self.username}'

    def get_fullname(self):
        """return the full name of the user"""
        return f'{self.name}'

    def has_perm(self, perm, obj=None):
        return self.is_staff

    def has_module_perms(self, app_label):
        return True

    class Meta:
        """Meta data for the class"""
        db_table = 'Users'
        verbose_name_plural = 'Users'


class Notification(models.Model):
    send_to = (
        ('student', 'Student'),
        ('staff', 'Staff'),
        ('staff and student', 'Staff and Student'),
    )
    created_by = models.ForeignKey(
        to='User', on_delete=models.CASCADE, blank=True, null=True, related_name="created_by")
    title = models.CharField(max_length=100, blank=True, null=True)
    image = models.ImageField(null=True, upload_to='uploads/')
    file = models.FileField(upload_to='uploads/')
    receiver = models.CharField(
        max_length=20, choices=send_to, blank=True, null=True)
    description = models.TextField(max_length=1000, null=True, blank=True)
    date_created = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = 'Notifications'
        db_table = 'Notifications'

    def __str__(self):
        return f'CREATED: {self.created_by} | RECEIVED: {self.receiver}'
