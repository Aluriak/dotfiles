#!/usr/bin/env python3
"""Convert an asp file with edge/2 atoms
into slf/cxt file, needed for instance by lattice miner or inclose
algorithm implementation.

The slf/cxt file will be overwritten.

"""
import os
import sys
import argparse
import itertools
from collections import namedtuple, defaultdict
import clyngor

Context = namedtuple('Context', 'objects, attributes, relations')
# objects -- tuple of objects
# attributes -- tuple of attributes
# relations -- frozenset of holding (object, attribute)


def extract_context(input_file:str, names:[str]=('edge', 'rel'),
                    symetric:bool=False, anonymize:bool=False,
                    keep_quotes:bool=False, prefixed:bool=False) -> Context:
    model = next(clyngor.solve(input_file).careful_parsing.by_predicate)
    relations = model.get('edge', model.get('rel'))
    if not relations:
        raise ValueError("Given file ({}) do not contains edge/2 or rel/2, but {}"
                         "".format(input_file, ', '.join(links)))

    assert all(len(t) == 2 for t in relations)

    # format the identifiers
    formatted = lambda s: s.strip('"')
    if keep_quotes:
        formatted = lambda s: s.strip('"')
    if anonymize:
        gen_ids = itertools.count(1)
        ids = defaultdict(lambda: next(gen_ids))
        formatted = lambda s: str(ids[s])

    relations = (
        (formatted(obj), formatted(att))
        for obj, att in relations
    )

    with_prefix = lambda o, a: (o, a)
    if prefixed:
        with_prefix = lambda o, a: ('o' + o, 'a' + a)

    if symetric:
        relations = frozenset(
            with_prefix(ext, int_)
            for obj, att in relations
            for ext, int_ in ((obj, att), (att, obj))
        )
    else:  # keep given order
        relations = frozenset(
            with_prefix(obj, att)
            for obj, att in relations
        )
    objects = tuple(frozenset(obj for obj, _ in relations))
    attributes = tuple(frozenset(att for _, att in relations))

    return Context(objects, attributes, relations)



def write_as_slf(context:Context, fname:str):
    """Write in given file the given context in slf format"""
    with open(fname, 'w') as fd:
        fd.write('[Lattice]\n')
        fd.write('{}\n{}\n'.format(len(context.objects), len(context.attributes)))
        fd.write('[Objects]\n')
        fd.write('\n'.join(map(str, context.objects)) + '\n')
        fd.write('[Attributes]\n')
        fd.write('\n'.join(map(str, context.attributes)) + '\n')
        fd.write('[relation]\n')
        for obj in context.objects:
            fd.write(' '.join('1' if (obj, att) in context.relations else '0'
                              for att in context.attributes) + ' \n')



def write_as_cxt(context:Context, fname:str):
    """Write in given file the given context in cxt format"""
    with open(fname, 'w') as fd:
        fd.write('B\n\n')
        fd.write('{}\n{}\n\n'.format(len(context.objects), len(context.attributes)))
        fd.write('\n'.join(map(str, context.objects)) + '\n')
        fd.write('\n'.join(map(str, context.attributes)) + '\n')
        for obj in context.objects:
            fd.write(''.join('X' if (obj, att) in context.relations else '.'
                              for att in context.attributes) + '\n')


if __name__ == "__main__":


    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument('asp_file', type=str,
                        help='file containing the graph data in asp format')
    parser.add_argument('out_file', type=str,
                        help='output file. Will be overwritten.')
    parser.add_argument('--symetric', action='store_true',
                        help='objects and attributes are equivalent set with symmetric relations')
    parser.add_argument('--allow-quotes', action='store_true',
                        help='objects and attributes with quotes in ASP will keep them')
    parser.add_argument('--anonymize', action='store_true',
                        help='replace objects and attributes with integers. Remove quotes.')
    parser.add_argument('--prefixed', action='store_true',
                        help='prefix objects with o and attributes with a. Useful when --symetric')
    args = parser.parse_args()

    writers = {'slf': write_as_slf, 'cxt': write_as_cxt}
    output_extension = os.path.splitext(args.out_file)[1][1:]
    writer = writers.get(output_extension)
    if writer:
        context = extract_context(args.asp_file, symetric=args.symetric,
                                  keep_quotes=args.allow_quotes,
                                  anonymize=args.anonymize,
                                  prefixed=args.prefixed)
        writer(context, args.out_file)
    else:
        raise ValueError("Output file has an unexpected extension ({}). "
                         "Valid ones are: {}"
                         "".format(output_extension, ', '.join(writers)))
