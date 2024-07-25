# Generated by Django 4.2.14 on 2024-07-16 07:26

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Customer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(max_length=300)),
                ('last_name', models.CharField(max_length=300)),
                ('address', models.CharField(max_length=600)),
            ],
        ),
        migrations.CreateModel(
            name='LoanOffer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('loanAmount', models.DecimalField(decimal_places=2, max_digits=10)),
            ],
        ),
    ]
