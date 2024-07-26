# Generated by Django 4.2.14 on 2024-07-16 11:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('amort', '0004_loanoffer_customer'),
    ]

    operations = [
        migrations.AddField(
            model_name='loanoffer',
            name='monthlyPayment',
            field=models.DecimalField(decimal_places=2, default=0.0, max_digits=10),
            preserve_default=False,
        ),
    ]