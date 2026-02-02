from django.shortcuts import render, redirect

from crm.forms import NotesForm
from crm.models import Notes


# Create your views here.
def home(request):
    if request.method == "POST":
        form = NotesForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect(home)
    else:
        form = NotesForm()
    notes = Notes.objects.all()
    return render(request, 'index.html', {'form': form, 'notes': notes})
