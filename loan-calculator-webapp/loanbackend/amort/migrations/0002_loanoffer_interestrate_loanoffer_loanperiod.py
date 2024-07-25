# Generated by Django 4.2.14 on 2024-07-16 10:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('amort', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='loanoffer',
            name='interestRate',
            field=models.DecimalField(decimal_places=2, default=0.0, max_digits=3),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='loanoffer',
            name='loanPeriod',
            field=models.DecimalField(decimal_places=0, default=6, max_digits=5),
            preserve_default=False,
        ),
    ]
