from django.http.response import HttpResponseRedirect
from django.shortcuts import render
from django.contrib.auth import decorators, forms, authenticate, login, logout
from django.contrib import messages

def index(request):
    return render(request,"accounts/index.html")

def userLogin(request):
    if request.user.is_authenticated:
        return HttpResponseRedirect("/accounts/")

    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            messages.success(request,"Login successful")
            return HttpResponseRedirect("/accounts/")
        else:
            messages.error(request,"No such user exists")

    form = forms.AuthenticationForm(request.POST)
    return render(request, 'accounts/login.html', {'form': form})
            
@decorators.login_required()
def userLogout(request):
    logout(request)
    messages.success(request,"Logout successful")
    return HttpResponseRedirect('/accounts/')

def userRegister(request):
    if request.method == 'POST':
        form = forms.UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            messages.success(request,"User registered successfully")
            return HttpResponseRedirect("/accounts/")
        else:
            messages.error(request,form.errors)

    form = forms.UserCreationForm()
    return render(request, 'accounts/register.html', {'form': form})