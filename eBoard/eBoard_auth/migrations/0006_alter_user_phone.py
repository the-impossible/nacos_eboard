# Generated by Django 4.2.2 on 2024-02-17 10:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("eBoard_auth", "0005_user_phone"),
    ]

    operations = [
        migrations.AlterField(
            model_name="user",
            name="phone",
            field=models.CharField(db_index=True, max_length=14, unique=True),
        ),
    ]
