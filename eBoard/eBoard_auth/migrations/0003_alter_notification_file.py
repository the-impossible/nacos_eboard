# Generated by Django 4.2.2 on 2023-07-01 18:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("eBoard_auth", "0002_notification"),
    ]

    operations = [
        migrations.AlterField(
            model_name="notification",
            name="file",
            field=models.FileField(blank=True, null=True, upload_to="uploads/"),
        ),
    ]
