from django import forms
from crm.models import Notes
class NotesForm(forms.ModelForm):
    class Meta:
        model = Notes
        fields = "__all__"