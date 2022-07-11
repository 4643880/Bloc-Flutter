import 'package:bloc_course/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_course/blocs/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocConsumer<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetLostState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Internet is not Connected...")));
        } else if (state is InternetGainedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Internet Connected..."),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Loading"),
            ),
          );
        }
      },
      builder: (context, state) {
        // == uses to check value
        // is uses to check datatype
        if (state is InternetLostState) {
          return const Text("Internet is not Connected...");
        } else if (state is InternetGainedState) {
          return const Text("Internet Connected...");
        } else {
          return const Text("Loading...");
        }
      },
    )
        // child: BlocBuilder<InternetBloc, InternetState>(
        //   builder: (context, state) {
        //     // == uses to check value
        //     // is uses to check datatype
        //     if (state is InternetLostState) {
        //       return const Text("Please check Internet Connection...");
        //     } else if(state is InternetGainedState) {
        //       return const Text("Internet is working...");
        //     }else{
        //       return const Text("Loading...");
        //     }
        //   },
        // ),
        );
  }
}
